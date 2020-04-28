require 'rails_helper'
RSpec.describe LinksController, type: :controller do

  describe "GET #show" do
    link = Link.create(url: 'http://google.com/')
    context "with valid slug" do
      it "redirects to link url" do
        get :show, params: { slug: link.slug }
        expect(response).to redirect_to(link.url)
      end
    end

    context "with invalid slug" do
      it "redirect to root" do
        link.inactive!
        get :show, params: { slug: link.slug }
        expect(response).to redirect_to(:root)
      end

      it "redirect to root" do
        link.active!
        link.update_column(:valid_till, (Time.now - 2.days))
        get :show, params: { slug: link.slug }
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe "GET #new" do
    it "assigns new link to @link" do
      get :new
      expect(assigns(:link)).to be_a_new(Link)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #stats" do
    it "assigns links to @links" do
      get :stats
      expect(assigns(:links)).to eq(Link.all)
    end

    it "renders the :stats template" do
      get :stats
      expect(response).to render_template(:stats)
    end
  end

end
