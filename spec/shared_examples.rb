shared_examples_for 'a period' do

  describe "#referrers" do
    it { element.should respond_to(:referrers) }
    it { element.referrers.first.should respond_to(:count) }
    it { element.referrers.first.should respond_to(:label) }
  end

  describe "#countries" do
    it { element.should respond_to(:countries) }
    it { element.countries.first.should respond_to(:count) }
    it { element.countries.first.should respond_to(:label) }
  end

  describe "#browsers" do
    it { element.should respond_to(:browsers) }
    it { element.countries.first.should respond_to(:count) }
    it { element.countries.first.should respond_to(:label) }
  end

  describe "#platforms" do
    it { element.should respond_to(:platforms) }
    it { element.countries.first.should respond_to(:count) }
    it { element.countries.first.should respond_to(:label) }
  end

end

shared_examples_for 'a clicks' do

  describe "#short_url_clicks" do
    it { element.should respond_to(:short_url_clicks) }
  end

  describe "#long_url_clicks" do
    it { element.should respond_to(:long_url_clicks) }
  end

end
