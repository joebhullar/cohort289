require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "#new" do
      it "renders the new template" do
        get :new
        # response here is a method from RSpec Rails that we can use to match
        # the output or the result of making a specific request
        # render_template is an RSpec matcher for Rails just likereiirect or render_template
        expect(response).to render_template(:new)
      end

      it "instantiates a new campaign instance variable" do
        get :new

        # assigns(:product) will check a variable named @product defined within
        # the controller.
        expect(assigns(:product)).to be_a_new(Product)

      end
    end

    describe "#create" do
        context "with valid parameters" do
          #THIS IS A METHOD WE HAVE DEFINED FOR valid_request WHAT THIS DOES IS IT CREATES ANOTHER REQUEST!
          def valid_request
            post :create, params: { product: {title: "DragonBallGT",
                                               price:345,
                                               description: "dbgt",
                                              #end_date: Time.now + 50.days
                                              } }
          end

          it "saves a record to the database" do
            count_before = Product.count
            valid_request
            count_after = Product.count
            expect(count_after).to eq(count_before + 1)
          end

          it "redirects to the product index (aka show) page" do
            valid_request
            expect(response).to redirect_to(products_path())
            #IF we wanted to check if it redirected to the last product page on 1 specific product path THEN we would write
            #expect(response).to redirect_to(product_path(Product.last))
          end

          it "sets a flash message" do
            valid_request
            expect(flash[:notice]).to be
          end
        end
        context "with invalid parameters" do
          def invalid_request
            post :create, params: {product: {title: "", price:45, description:""}}
          end

          it "renders the new template" do
            invalid_request
            expect(response).to render_template(:new)
          end

          it "doesn't save the record to the database" do
            count_before = Product.count
            invalid_request
            count_after = Product.count
            expect(count_after).to eq(count_before)
          end
        end
      end



end
