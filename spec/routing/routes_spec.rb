describe 'Routes' do

  it "routes / to links#new" do
    expect(get: "/").to route_to(
      controller: "links",
      action: "new"
    )
  end

  it "routes /stats to links#stats" do
    expect(get: "/stats").to route_to(
      controller: "links",
      action: "stats"
    )
  end

  it "routes /:slug to links#show" do
    expect(get: "/slug").to route_to(
      controller: "links",
      action: "show",
      slug: "slug"
    )
  end

  it "routes /links to links#create" do
    expect(post: "/links").to route_to(
      controller: "links",
      action: "create"
    )
  end

end