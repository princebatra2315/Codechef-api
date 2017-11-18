class GetuserController < ApplicationController
class GetuserController < ApplicationController

	@username = nil
	def get_user
		@username = params[:user]
		
		if(params[:user])
			resource = RestClient::Resource.new 'https://codechef.com/users/'+@username
			@data=resource.get
		end
	
		@reponse=@data.index("<dd>")
		@jsondata=Hash.new
		problemssolved=0
		multiplier=1

		if (@data.include? "<dd>")
			if(@data[@reponse+7]>='0' && @data[@reponse+7]<='9')
				problemssolved+=(@data[@reponse+7].to_i)*multiplier
				multiplier*=10
			end
			
			if(@data[@reponse+6]>='0' && @data[@reponse+6]<='9')
				problemssolved+=(@data[@reponse+6].to_i)*multiplier
				multiplier*=10
			end

			if(@data[@reponse+5]>='0' && @data[@reponse+5]<='9')
				problemssolved+=(@data[@reponse+5].to_i)*multiplier
				multiplier*=10
			end
			
			if(@data[@reponse+4]>='0' && @data[@reponse+4]<='9')
				problemssolved+=(@data[@reponse+4].to_i)*multiplier
				multiplier*=10
			end

			@jsondata['codechef']=Hash.new
			@jsondata['codechef']['handle']=@username
			@jsondata['codechef']['problemssolved']=problemssolved
		else
			@jsondata['spoj']=Hash.new
			@jsondata['spoj']['error']="Spoj user does not exist"	
		end	

		render :json=>@jsondata.to_json
	end
end
end