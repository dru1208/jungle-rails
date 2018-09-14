class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
  def order_email(order)
    @order = order
    mail(to: @order.email, subject: 'Your order #{@order.id} from Jungle!')
  end
end
