module MessagesHelper

  def mark_up(message)
    parts = message.split "\n"
    parts.map {|s| h(s)}.join(" <br/>").gsub(/(http|https|ftp)([^ ]+)/i) {|s|  "<a href='#{s}'>#{s}</a>"}        
  end

  def xx_mark_up(message)
    require 'bluecloth'
    BlueCloth::new( message ).to_html
  end

  def display_attachment(message)
    if message.has_image?
      '<div class="img_attachment">' + link_to( image_tag( message.attachment.url(:big) ), message.attachment.url, :target => '_blank' ) + "</div>"
    elsif message.has_pdf?
      %Q(
        <div class="file_attachment">
        #{link_to( image_tag( 'icons/pdf_large.jpg', :alt => 'PDF Document', :width => 100 ), message.attachment.url, :target => '_blank' )}
        </div>
      )
    end
  end

end
