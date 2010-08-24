require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Activity do
  describe "belonging to friend tie" do
    before do
      @a = Factory(:activity, :tie => Factory(:friend_tie))
      @ft = @a.tie
    end

    describe "accessed by friend" do
      before do
        u = @ft.receiver.sender
        @ability = Ability.new(u)
      end
    end

    describe "accessed by other friend" do
      before do
        t = Factory(:friend_tie, :receiver => @ft.receiver)
        u = t.sender.subject
        @ability = Ability.new(u)
      end

      it "should allow read" do
        @ability.should be_able_to(:read, @a)
      end

      it "should deny update" do
        @ability.should_not be_able_to(:update, @a)
      end

      it "should deny destroy" do
        @ability.should_not be_able_to(:destroy, @a)
      end
    end

    describe "accessed by friend of friend" do
      before do
        t = Factory(:fof_tie, :receiver => @ft.receiver)
        u = t.sender.subject
        @ability = Ability.new(u)
      end

      it "should deny read" do
        @ability.should_not be_able_to(:read, @a)
      end

      it "should deny update" do
        @ability.should_not be_able_to(:update, @a)
      end

      it "should deny destroy" do
        @ability.should_not be_able_to(:destroy, @a)
      end
    end

    describe "accessed by other" do
      before do
        t = Factory(:public_tie, :receiver => @ft.receiver)
        u = t.sender.subject
        @ability = Ability.new(u)
      end

      it "should deny read" do
        @ability.should_not be_able_to(:read, @a)
      end

      it "should deny update" do
        @ability.should_not be_able_to(:update, @a)
      end

      it "should deny destroy" do
        @ability.should_not be_able_to(:destroy, @a)
      end
    end

  end
end
