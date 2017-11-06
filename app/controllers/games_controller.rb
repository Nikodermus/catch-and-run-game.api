class GamesController < ApplicationController
	def create
		if current_user
			user = current_user
			game = Game.new(
				:score => 0,
				:difficulty => game_params[:difficulty],
				:user_id => user[:id],
				)
			if game.save
				render_success game: game.as_json(:except=>[:img_path])
			else
				render_error "Game couldn't be saved"
			end
		else
			render_error "Game not created!"
		end
	end

	def update
		if current_user
			game = Game.find_by id: game_params[:id]
			duration = (DateTime.now.to_time - game[:created_at].to_time).to_i;
			print "durations is ... #{duration}"
			if game
				game.update(
					:score => game_params[:score],
					:img_path => game_params[:img_path],
					:duration => duration
				)
				render_success game: game.as_json(:except => [:img_path])
			end
		else
			render_error 'Game not saved'
		end
	end

	private 

	def game_params
		params.require(:game).permit(:img_path, :difficulty, :score, :id)
	end
end
