require 'rack'
require 'application'
require 'adaptive_images'

use AdaptiveImages
run Application.new
