class ProductsController < ApplicationController
      #THESE ARE OUR CONTROLLER ACTIONS  AND THEY MAP ROUTS TO THE HTTP VERBS. THE ROUTS GO TO A VERB AND A PATH.
      #IF WE ENTER AN INVALID ID IT it will ignore it and return the database result BECAUSE
      #WE ONLY RUN find_product on show and edit AND THEREFORE that does not run on Index which is why the range outside table is ignored.

      #THE DEFAULT RETURN VALUE OF AN ACTION IS TO RENDER THAT ACTION's VIEW IF you have an action called show it will render show.html.erb
      #first on stuff it SHOULD run on and stuff it SHOULDNT RUN on

      before_action :find_product, only: [:show , :edit, :destroy]
      #SHOW IS USING HTTP VERB : GET BECAUSE ITS SHOWING SOMETHING ON SCREEN
      # WE CAN DELETE SHOW AND IT WILL STILL WORK BECAUSE show action is a method that is declared in the applications controller
      #We are really just overriding behaviours from preivous methods being passed down.
      #THIS IS TRUE FOR show, index,edit ALL GENERIC ACTIONS! OR STANDARD ACTIONS.

      def show
        # id=params[:id]
        # @product=Product.find(id)
        # @product=Product.find(params[:id])
      end #SHOW ONLY SHOWS 1 BY ID

      #INDEX IS USING HTTP VERB GET:
      #@products= #HOW DO WE GET DATA OUT OF THE DATABASE
      def index
                #HAS TO MATCH THE CLASS Product
                #SHOWS ALL OF THEM
                @products=Product.all

      end


    #Edit is an action name THAT SENDS THE USER TO THE FORM. (WITH EDIT: THAT FORM IS ALRREADY POPULARED). THEN WE USE THE UPDATE ACTION TO SENDS
    def edit
    end
    # #THE DATA BACK TO THE MODEL WHICH UPDATES THE DATA TO THE TABLE!
    #
    # #HTTP VERB: GET : BECAUSE WE ARE JUST DISPLAYING SOMETHING
    # #FOR EDIT ITS SIMILAR TO CREATE EXCEPT WE HAVE TO PRE-POPULATE THE EDIT TEXT FIELDS!
    #
    # # productparams = params.require(:product).permit(params[:title]:,params[:price],params[:description])
    #   @product=Product.find(params[:id])
    # # productparams = params.require(:product).permit(:title,:price,:description)
    #
    # Product.create(productparams)


    #HTTP VERB WE CAN USE PATCH OR PUT
    #PATCH BECAUSE HTTP  BECAUSE WERE PATCHING SOMETHIGN ONTO THE SeRVER BECAUSE IT ALREADY EXISTS AND WERE JUST "PATCHING"IT
    #OR POST BECAUSE WE CAN BE SEEN AS POSTING SOMETHING "NEW"
    def update
      productparams = params.require(:product).permit(:title,:price,:description)

      @product=Product.update productparams
      # link_to products_path WILL NOT WORK BECAUSE THIS GENERATS AN HTML TAG LIKE a href this  will not work in ruby
      #This redirects to the products pageid itself!
      redirect_to product_path(@product)
    end

    def new
      #SHOW IS USING HTTP VERB : GET BECAUSE ITS SHOWING SOMETHING ON SCREEN NEW IS JUST DISPLAYING A FORM
      @product=Product.new
      #INSTANCIANTE A PRODUCE. Created an instance of the produce IN THE MEMORY

      #New purpose is to show the forms but not to rediret
    end


    #HTTP VERB: POST : BECAUSE IN TERMS OF HTTP: HTTP SAYS WHEN WE ARE DOING POST WE ARE EXPECTED TO DO SOMETHING THAT HAS AN
    #EFFECT ON THE SERVER. GET YOU CAN JUST GET OVER AND OVER AGAIN.
    def create #NEW DOSNT SAVE TO DATABASE BUT CREATE MAKES A NEW INSTANCE OF THE OBJECT AND SAVES TO DB !
      productparams = params.require(:product).permit(:title,:price,:description)

      #THIS CODE IS RUNNING ON THE SERVER> RUBY CODE HAS TO BE RUN ON THE SERVER SO THIS CODE RUNS ON THE
      #SENDS THE DATA TO THE TABLE IN THE DATABASE!
      @product=Product.new(productparams) #CREATE CALLS NEW AND SAVE TAHATS WHY WE JUST USED new HERE!!! NOT create!
      #########################################################################
      ### THIS IS COMMENTED BELOW BEACUSE WE HAVE CREATED THE HTML VIEW PAGE
      # redirect_to products_path #render requries you to look back at the data. Render would be good for an update or somthing
      # We would use render if we are updating something. We use render when theres not a convninent way yo redirect.

      #CREATE DOES NOT NEED A VIEW

      if @product.save#BOOLEANS TO SAVE aT THIS INSTANCE
        redirect_to products_path(), notice: "Helll Yeahhhh THIS IS THE Flash Notice in the code redirect_to products_path(@product), notice: Only visibale after redirect to product path has been redirected to that URL "
      else
        render :new
      end

    end
    #HTTP VERB DELETE
    def destroy
      # find_product has already been run which means that @product is available
      @product.destroy
      redirect_to products_path
    end

  private

  def find_product
    #anything i do here is run before other methods and is accesible to other methods. if i define an instance variable here it will be accessable to views and to my other controller methods.
    #~WE CANNOT RUN THIS ON INDEX BECAUSE THERE IS NO product[:id] on index
    id=params[:id]
    #@product is available in my view so thats the reason that I can leave the SHOW emthod empoty and have @product commented out in there
    @product=Product.find(id)
  end
end
