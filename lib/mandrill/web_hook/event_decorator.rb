# Wraps an individual Mandrill web hook event payload,
# providing some convenience methods handling the payload.
#
# Given a raw event payload Hash, wrap it thus:
#
#   JSON.parse(params['mandrill_events']).each do |raw_event|
#     event = Mandrill::WebHook::EventDecorator[raw_event]
#     ..
#   end
#
class Mandrill::WebHook::EventDecorator < Hash
  
  def as_record
    event_payload = self
    attributes_data = event_payload.to_hash
    attributes_data["internal_id"] = attributes_data.delete("_id")
    attributes_data["msg"]["internal_id"] = attributes_data["msg"].delete("_id")
    attributes_data["msg"]["internal_version"] = attributes_data["msg"].delete("_version")
    attributes_data["msg"]["opens_attributes"] = attributes_data["msg"].delete("opens")
    attributes_data["msg"]["clicks_attributes"] = attributes_data["msg"].delete("clicks")
    attributes_data["msg"]["smtp_events_attributes"] = attributes_data["msg"].delete("smtp_events") if not attributes_data["msg"]["smtp_events"].nil? 
    attributes_data["msg"]["metadata"] = attributes_data["msg"]["metadata"].to_json 
    attributes_data["msg"]["resends"] = attributes_data["msg"]["resends"].to_json if not attributes_data["msg"]["resends"].nil?  
    attributes_data["msg"]["tags"] = attributes_data["msg"]["tags"].to_json
    attributes_data["msg_attributes"] = attributes_data.delete("msg")
    attributes_data["location_attributes"] = attributes_data.delete("location") || {}
    attributes_data["user_agent_parsed_attributes"] = attributes_data.delete("user_agent_parsed") || {}
    #::Rails.logger.ap attributes_data 
    event_email = Mandrill::EmailEvent.new(attributes_data)
    event_email
  end

  # Returns the event type.
  # Applicable events: all
  def event_type
    self['event']
  end

  # Returns the message subject.
  # Applicable events: all
  def subject
    self['subject'] || msg['subject']
  end

  # Returns the msg Hash.
  # Applicable events: all
  def msg
    self['msg']||{}
  end

  # Returns the message_id.
  # Inbound events: references 'Message-Id' header.
  # Send/Open/Click events: references '_id' message attribute.
  def message_id
    headers['Message-Id'] || msg['_id']
  end

  # Returns the Mandrill message version.
  # Send/Click events: references '_version' message attribute.
  # Inbound/Open events: n/a.
  def message_version
    msg['_version']
  end

  # Returns the reply-to ID.
  # Applicable events: inbound
  def in_reply_to
    headers['In-Reply-To']
  end

  # Returns an array of reference IDs.
  # Applicable events: inbound
  def references
    (headers['References']||'').scan(/(<[^<]+?>)/).flatten
  end

  # Returns the headers Hash.
  # Applicable events: inbound
  def headers
    msg['headers']||{}
  end

  # Returns the email (String) of the sender.
  # Applicable events: inbound
  def sender_email
    msg['from_email']
  end

  # Returns the subject user email address.
  # Inbound messages: references 'email' message attribute (represents the sender).
  # Send/Open/Click messages: references 'email' message attribute (represents the recipient).
  def user_email
    msg['email']
  end

  # Returns an array of all unique recipients (to/cc)
  #   [ [email,name], [email,name], .. ]
  # Applicable events: inbound
  def recipients
    (Array(msg['to']) | Array(msg['cc'])).compact
  end

  # Returns an array of all unique recipient emails (to/cc)
  #   [ email, email, .. ]
  # Applicable events: inbound
  def recipient_emails
    recipients.map(&:first)
  end

  # Returns an array of Mandrill::WebHook::Attachment objects describing each attached file
  #   [ attachment, attachment, .. ]
  # Applicable events: inbound
  #
  # NB: we are throwing away the Mandrill attachments hash keynames at this point, since in practice they
  # are usually the same as the filename. Does this matter? May need to review if other cases are identified.
  def attachments
    (msg['attachments']||{}).map{|attached| Mandrill::WebHook::Attachment[attached.last] }
  end

  # Returns the +format+ (:text,:html,:raw) message body.
  # If +format+ is not specified, it will return the first available message content in order: text, html, raw.
  # Applicable events: inbound
  def message_body(format=nil)
    case format
    when :text
      msg['text']
    when :html
      msg['html']
    when :raw
      msg['raw_msg']
    else
      msg['text'] || msg['html'] || msg['raw_msg']
    end
  end

  # Returns the primary click payload or nil if n/a.
  # Applicable events: click, open
  def click
    { 'ts' => self['ts'], 'url' => self['url'] } if self['ts'] && self['url']
  end

  # Returns an array of all the clicks.
  # Applicable events: click, open
  def all_clicks
    clicks = msg['clicks'] || []
    clicks << click if click and clicks.empty?
    clicks
  end

  # Returns an array of all the urls marked as clicked in this message.
  # Applicable events: click, open
  def all_clicked_links
    all_clicks.collect{|c| c['url'] }.uniq
  end
end
