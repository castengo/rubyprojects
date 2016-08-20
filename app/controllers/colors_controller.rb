class ColorsController < ApplicationController
	before_action :set_color, only: [:show]
	#get colors
	def index
		@colors = Color.all.order(:r)
	end

	def show
		@shade_names = @color.shades.pluck(:name).first
		@spot_on_colors = Color.close_colors(@color,10)
		# @close_call_shades = Color.product_match(@color,20)
		@close_call_colors = Color.close_colors(@color,20).where.not(id: @spot_on_colors.map { |color| color.id })
	end

	private 

	def set_color
		@color = Color.find(params[:id])
	end

end
