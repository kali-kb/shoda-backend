class OrderMailer < ApplicationMailer

	def order_success
	    invoice_data = {
	      customer_name: "customer_name",
	      invoice_number: "invoice_number",
	      # ... include other invoice details
	    }

	    pdf = Prawn::Document.new

	    # Add invoice details to the PDF
	    pdf.text "Invoice for #{invoice_data[:customer_name]}"
	    pdf.text "Invoice Number: #{invoice_data[:invoice_number]}"
	    # Add other invoice details using pdf.text or other Prawn methods

	    # Optional: Add a table for invoice items if needed

	    # mail(to: "mtemporary193@gmail.com", subject: "Your Order Confirmation - Shoda") do |mail|
	    #   mail.html_part do |html|
	    #     html.body = "Thank you for your order! Please find your invoice attached."
	    #   end
	    #   mail.attachments["invoice.pdf"] = { data: pdf.render, content_type: "application/pdf" }
	    # end
 	end


end
