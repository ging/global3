require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActivityTestHelper
  def assigned_to(tie)
    @tie = tie
    @activity = Factory(:activity, :tie => tie)
  end

  def accessed_by(tie)
    u = tie.sender.subject
    @ability = Ability.new(u)
  end

  def it_should_allow(action)
    @ability.should be_able_to(action, @activity)
  end

  def it_should_deny(action)
    @ability.should_not be_able_to(action, @activity)
  end
end

describe Activity do
  include ActivityTestHelper

  describe "belonging to friend tie" do
    before do
      assigned_to(Factory(:friend_tie))
    end

    describe "accessed by friend" do
      before do
        u = @ft.receiver.sender
        @ability = Ability.new(u)
      end
    end

    describe "accessed by other friend" do
      before do
        accessed_by Factory(:friend_tie, :receiver => @tie.receiver)
      end

      it "should allow read" do
        it_should_allow(:read)
      end

      it "should deny update" do
        it_should_deny(:update)
      end

      it "should deny destroy" do
        it_should_deny(:destroy)
      end
    end

    describe "accessed by friend of friend" do
      before do
        accessed_by Factory(:fof_tie, :receiver => @tie.receiver)
      end

      it "should deny read" do
        it_should_deny(:read)
      end

      it "should deny update" do
        it_should_deny(:update)
      end

      it "should deny destroy" do
        it_should_deny(:destroy)
      end
    end

    describe "accessed by other" do
      before do
        accessed_by Factory(:public_tie, :receiver => @tie.receiver)
      end

      it "should deny read" do
        it_should_deny(:read)
      end

      it "should deny update" do
        it_should_deny(:update)
      end

      it "should deny destroy" do
        it_should_deny(:destroy)
      end
    end
  end
end
