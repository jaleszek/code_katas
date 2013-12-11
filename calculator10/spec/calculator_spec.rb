require 'spec_helper'

describe StringCalculator do
  it { _add('').should == 0 }
  it { _add('1').should == 1 }
  it { _add('2,1').should == 3 }

  it { _add('2,3,4,5').should == 14 }
  it { _add('10,100,1,1,1,1').should == 114 }
  
  context 'for mixed standard delimiters' do
    it { _add("1,2\n3,4\n5").should == 15 }
    it { _add("1\n2\n3\n4\n5").should == 15 }
  end

  context 'for custom delimiter' do
    it { _add("//;\n1;2,3;4\n5").should == 15 }
    it { _add("//.\n10.100.12").should == 122 }
    it { _add("//n\n10n12n13n10").should == 45 }

    context 'for any length of delimiter' do
      it { _add("//[;;][..]['']\n1;;2..3''4..5\n5").should == 20 }
      it { _add("//[**][&][;;;;]\n2**12&10;;;;100&1").should == 125 }
    end
  end

  context 'for negative numbers' do
    it do
      lambda { "-1,2".extend(StringCalculator).add }.should raise_error
    end
  end

  context 'for big numbers' do
    it 'ignore numbers larger than 1000' do
      _add('1001,1000,100,10000,88888').should == 1100
    end
  end
end

def _add(args)
  args.extend(StringCalculator).add
end