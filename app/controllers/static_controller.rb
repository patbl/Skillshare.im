class StaticController < ApplicationController
  skip_before_action :authorize
end
