require 'rails_helper'

RSpec.describe Link, type: :model do

  describe 'constants' do
    it "returns the unique slug length" do
      expect(Link::UNIQUE_SLUG_LENGTH.should eq(5))
    end

    it "returns the number of days slug is valid for" do
      expect(Link::VALID_FOR_DAYS.should eq(30))
    end
  end

  describe 'validations' do

    it { should_not allow_value('google').for(:url) }
    it { should allow_value('http://google.com/').for(:url) }
    it { should allow_value('https://google.com/').for(:url) }
    it { should allow_value('http://www.google.com/').for(:url) }

    it "is invalid without attributes" do
      link = Link.new()
      expect(link).to be_invalid
    end

    it "is invalid with invalid attributes" do
      link = Link.new(url: 'google')
      expect(link).to be_invalid
    end

    it "is valid with valid attributes" do
      link = Link.new(url: 'http://google.com')
      expect(link).to be_valid
    end

    it "validates url" do
      link = Link.create(url: '')
      expect(link.errors[:url]).to include('is not a valid URL')
    end

  end

  describe 'saves auto generated fields' do

    link = Link.create(url: 'https://google.com')
    it "generates slug" do
      expect(link.slug).to_not eq nil
    end

    it "generates slug size of length 5" do
      expect(link.slug.length).to eq 5
    end

    it "saves valid till" do
      expect(link.valid_till).to_not eq nil
    end

    it "valid till is greater then today" do
      expect(link.valid_till).to be > Time.now
    end

    it "sanitize url - removes https" do
      expect(link.url).to eq ('http://google.com')
    end

    it "sanitize url - removes www" do
      link.url = 'http://www.google.com'
      link.save!
      expect(link.url).to eq ('http://google.com')
    end

  end

  describe 'checks scopes' do
    link = Link.create(url: 'https://google.com')

    it 'scope options' do
      expect(Link.statuses).to eq({"active"=>0, "inactive"=>1})
    end

    it 'default status value is active' do
      expect(link.status).to eq 'active'
    end
  end

  describe 'public methods' do

    context '#is_valid?' do
      it 'return false' do
        link = Link.new(valid_till: 2.days.ago)
        expect(link.is_valid?).to eq(false)
      end

      it 'return true' do
        link = Link.new(valid_till: (Time.now + 2.days))
        expect(link.is_valid?).to eq(true)
      end
    end

    context '#sanitized_url' do
      it { expect(Link.sanitized_url('https://google.com')).to eq('http://google.com') }
      it { expect(Link.sanitized_url('https://www.google.com')).to eq('http://google.com') }
      it { expect(Link.sanitized_url('http://google.com')).to eq('http://google.com') }
    end

    context '#top_countries' do
      link = Link.last
      link.link_analytics.create(country: 'USA')
      link.link_analytics.create(country: 'India')
      link.link_analytics.create(country: 'India')
      it { expect(link.top_countries).to eq(['India', 'USA']) }
    end

  end

end
