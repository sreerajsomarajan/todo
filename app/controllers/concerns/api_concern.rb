#
# To handle all common methods for APIs
#
# @author [sreeraj s]
#
module ApiConcern
  extend ActiveSupport::Concern

  # Common response for API requests.
  def common_response(message, opt = {})
    status_code = opt.delete(:status)
    status = @success ? :ok : :internal_server_error
    status = status_code if status_code.present?
    res = {
      success: @success, # Defined in the BaseApisController
      message: (message.is_a?(String) ? Array(message) : message)
    }
    res = res.merge!(opt) if opt.present? && @success
    render json: res, status: status
  end
end
