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

    context "redirect to root with invalid slug" do
      it "with inactive link" do
        link.inactive!
        get :show, params: { slug: link.slug }
        expect(response).to redirect_to(:root)
      end

      it "with expired link" do
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

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new link" do
        expect{
          post :create, xhr: true, params: {link: {url: Faker::Internet.url}}
        }.to change(Link,:count).by(1)
      end

      it "assigns link to @link" do
        post :create, xhr: true, params: {link: {url: Faker::Internet.url}}
        expect(assigns(:link)).to eq(Link.last)
      end

      it "assigns nil to @link" do
        post :create, xhr: true, params: {link: {url: Link.last.url}}
        expect(assigns(:link)).to eq(nil)
      end

      it "assigns nil to @existing_link" do
        post :create, xhr: true, params: {link: {url: Faker::Internet.url}}
        expect(assigns(:existing_link)).to eq(nil)
      end

    end

    context "with invalid attributes" do
      it "does not save the new link" do
        expect{
          post :create, xhr: true, params: {link: {url: nil}}
        }.to_not change(Link,:count)
      end

      it "does raises validation error" do
        post :create, xhr: true, params: {link: {url: nil}}
        expect(assigns(:link).errors[:url]).to include("is not a valid URL")
      end
    end
  end

end
