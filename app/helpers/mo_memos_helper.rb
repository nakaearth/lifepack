module MoMemosHelper
   def format_string_length(message, max_length)
    if (message.length > max_length)
      return CGI.escapeHTML(message[0,max_length]+"・・・・")
    else
      return CGI.escapeHTML(message)
    end
  end
end
