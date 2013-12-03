require 'spec_helper'

describe StringCalculator do
  context 'for 0 arguments' do
    # for 0 arguments returns 0
    it { should_add("").should == 0 }
  end

  context 'for 1 argument' do
    it { should_add("1").should == 1 }
    it { should_add("10").should == 10 }
    it { should_add("111").should == 111 }
  end

  context 'for 2 arguments' do
    it { should_add("1,1").should == 2 }
    it { should_add("10,10").should == 20 }
    it { should_add("10,1").should == 11 }
    it { should_add("21,12").should == 33 }
  end

  context 'for any number of arguments' do
    it { should_add("0,1,0,11,111").should == 123 }
    it { should_add("1,2,3,4,5").should == 15 }
    it { should_add("0,0,0,0,0,0,0,0,0,0,1,0").should == 1 }
  end
  
  context 'for new line delimiter' do
    it { should_add("0,1\n1,2,3").should == 7 }
    it { should_add("1,1,1,\n,1,1\n1").should == 6 }
    it { should_add("1,1\n1\n1\n1").should == 5 }
    it { expect(should_add("1,2\n3")).to eq(6) }
  end

  context 'for custom delimiter' do
    it { expect(should_add("//;\n1;2;3")).to eq(6) }
    it { expect(should_add("//.\n2.3.4.5")).to eq(14) }
    it { expect(should_add("//&\n1&10&11")).to eq(22) }
  end

  context 'for negative number input' do
    it { lambda{"-1,2".extend(StringCalculator).add }.should raise_error }
  end

  context 'for any number of delimiters' do
    it { expect(should_add("//[;;][.]\n1;;2;;3.4;;5")).to eq(15) }
    it { expect(should_add("//[''][,,][..]\n1''2,,3..4,,5,5")).to eq(20) }
    it { expect(should_add("//[`][''][||][{{]\n1`2`3''4||5{{5")).to eq(20) }
    it { expect(should_add("//[&&][*]\n1*1&&5*13")).to eq(20) }
  end
  
  context 'for big numbers' do
    let(:big_number) { rand(1_000) + 1_001 }
    it { expect(should_add("#{big_number},#{big_number},23,#{big_number}")).to eq(23) }
  end
end

def should_add(str)
  str.extend(StringCalculator).add
end
