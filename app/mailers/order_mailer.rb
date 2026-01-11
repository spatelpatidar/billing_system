class OrderMailer < ApplicationMailer
  def bill_email(order:)
    @order = order
    mail(
      to: @order&.customer&.email,
      subject: "Your Bill ##{order.id}"
    )
  end
end
