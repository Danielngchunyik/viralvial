require 'rails_helper'

describe Admin::AnnouncementsController, :type => :controller do
    let(:announcement) { create(:announcement) }
    
    describe "GET #new" do
        before do
          get :new
        end

        it "assign a new announcement to @listing" do
          expect(assigns(:announcement)).to be_a_new(Announcement)
        end

        it "renders the :new template" do
          expect(response).to render_template :new
        end
    end

    describe "GET #index" do

      let(:another_announcement) { create(:announcement) }

      before { get :index }

      it "populates an array of announcements" do
        expect(assigns(:announcements)).to include(another_announcement)
        expect(assigns(:announcements).to_a.count).to eq(1)
      end

      it "renders the :index template" do
        expect(response).to render_template :index
      end

        
    end

    describe "DELETE #destroy" do
      let(:another_announcement) { create(:announcement) }

      it "deletes the announcement from the database" do
            expect{
              delete :destroy, id: announcement
            }.to change(Announcement, :count).by(-1)
      end

      it "redirects to admin_announcement_path" do
        delete :destroy, id: announcement
        expect(response).to redirect_to admin_announcements_path
      end
    end


    describe "PATCH #update" do
       context "with valid attribute" do
         it "located the requested @listing" do
           patch :update, id: announcement, announcement: attributes_for(:announcement)
           expect(assigns(:announcement)).to eq announcement
         end

         it "changes @listing's attributes " do
           patch :update, id: announcement, announcement: attributes_for(:announcement, message: 'MOTD', title: 'Test Message')
           announcement.reload
           expect(announcement.message).to eq 'MOTD'
           expect(announcement.title).to eq 'Test Message'
         end

         # it "redirects to the updated listing" do
         #   patch :update, id: announcement, announcement: attributes_for(:announcement)
         #   expect(response).to redirect_to announcement
         # end
       end

       # context "with invalid attribute" do
       #   it "does not update the listing" do
       #     patch :update, id: announcement, announcement: attributes_for(:announcement, name: '') 
       #     listing.reload
       #     expect(listing.name).to_not eq ''
       #     expect(listing.name).to eq 'Marche Movenpick'
       #   end

       #   it "re-renders the :edit template" do
       #     patch :update, id: listing, listing: attributes_for(:listing, :invalid)
       #     expect(response).to render_template :edit
       #   end
       # end
     end
end