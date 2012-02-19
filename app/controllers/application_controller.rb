class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  #force_ssl
end
