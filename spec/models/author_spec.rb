require 'spec_helper'

describe Book do

 before do
    @author = Author.new(name: "Michail", surname: "Bulhakow")
  end

  subject { @author }

  it { should respond_to(:books) }
end