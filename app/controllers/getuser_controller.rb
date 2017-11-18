class GetuserController < ApplicationController

	def get_user
		@codechefuser=params[:codechef]
		begin
		response=RestClient.get('http://codechef.com/users/'+@codechefuser)
		@data=response.body
		@jsondata=Hash.new
		problemssolved=0
		multiplier=1
		if (@data.include? "Fully Solved (")
			@reponse=@data.index("Fully Solved (")
			if(@data[@reponse+17]>='0' && @data[@reponse+17]<='9')
			 	problemssolved+=(@data[@reponse+17].to_i)*multiplier
				multiplier*=10
			end
			
			if(@data[@reponse+16]>='0' && @data[@reponse+16]<='9')
				problemssolved+=(@data[@reponse+16].to_i)*multiplier
				multiplier*=10
			end

			if(@data[@reponse+15]>='0' && @data[@reponse+15]<='9')
				problemssolved+=(@data[@reponse+15].to_i)*multiplier
				multiplier*=10
			end
			
			if(@data[@reponse+14]>='0' && @data[@reponse+14]<='9')
				problemssolved+=(@data[@reponse+14].to_i)*multiplier
				multiplier*=10
			end

			@jsondata['codechef']=Hash.new
			@jsondata['codechef']['handle']=@codechefuser
			@jsondata['codechef']['problemssolved']=problemssolved
		
		else
			@jsondata['codechef']=Hash.new
			@jsondata['codechef']['data']=@data
			@jsondata['codechef']['error']="Codechef user does not exist"	
		end	
		rescue => e 
			@jsondata=Hash.new
			@jsondata['handle']=@codechefuser
			@jsondata['error'] = 'User does not exist'
        end
	 	render :json=>@jsondata.to_json
	 end
end