require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActivityTestHelper
  def create_activity_assigned_to(aux_tie)
    @tie = aux_tie
    @activity = Factory(:activity, :tie => aux_tie)
  end

  def create_ability_accessed_by(tie_type)
    aux_tie = Factory(tie_type, :receiver => @tie.receiver)
    u = aux_tie.sender.subject
    @ability = Ability.new(u)
  end

  shared_examples_for "Allows Creating" do
    it "should allow create" do
      @ability.should be_able_to(:create, @activity)
    end
  end
  
  shared_examples_for "Allows Reading" do
    it "should allow read" do
      @ability.should be_able_to(:read, @activity)
    end
  end
  
  shared_examples_for "Allows Updating" do
    it "should allow update" do
      @ability.should be_able_to(:update, @activity)
    end
  end
  
  shared_examples_for "Allows Destroying" do
    it "should allow destroy" do
      @ability.should be_able_to(:destroy, @activity)
    end
  end

  shared_examples_for "Denies Creating" do
    it "should deny create" do
      @ability.should_not be_able_to(:create, @activity)
    end
  end
  
  shared_examples_for "Denies Reading" do
    it "should deny read" do
      @ability.should_not be_able_to(:read, @activity)
    end
  end
  
  shared_examples_for "Denies Updating" do
    it "should deny update" do
      @ability.should_not be_able_to(:update, @activity)
    end
  end
  
  shared_examples_for "Denies Destroying" do
    it "should deny destroy" do
      @ability.should_not be_able_to(:destroy, @activity)
    end
  end
  
end

describe Activity do
  include ActivityTestHelper

  describe "belonging to friend tie" do
    before do
      create_activity_assigned_to(Factory(:friend_tie))
    end

    describe "accessed by same friend" do
      before do
        u = @tie.sender.subject
        @ability = Ability.new(u)
      end

      it_should_behave_like "Allows Creating"
      it_should_behave_like "Allows Reading"
      it_should_behave_like "Allows Updating"
      it_should_behave_like "Denies Destroying"
    end
    
    describe "accessed by different friend" do
      before do
        create_ability_accessed_by :friend_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Allows Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end

    describe "accessed by friend of friend" do
      before do
        create_ability_accessed_by :fof_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Denies Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end

    describe "accessed publicly" do
      before do
        create_ability_accessed_by :public_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Denies Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end
  end
  
  describe "belonging to friend of friend tie" do
    before do
      create_activity_assigned_to(Factory(:fof_tie))
    end
    
    describe "accessed by a friend" do
      before do
        create_ability_accessed_by :friend_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Allows Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end

    describe "accessed by same friend of friend" do
      before do
        u = @tie.sender.subject
        @ability = Ability.new(u)
      end

      it_should_behave_like "Allows Creating"
      it_should_behave_like "Allows Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end
    
    describe "accessed by different friend of friend" do
      before do
        create_ability_accessed_by :fof_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Denies Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end

    describe "accessed publicly" do
      before do
        create_ability_accessed_by :public_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Denies Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end
  end
  
  describe "belonging to public tie" do
    before do
      create_activity_assigned_to(Factory(:fof_tie))
    end
    
    describe "accessed by a friend" do
      before do
        create_ability_accessed_by :friend_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Allows Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end

    describe "accessed by friend of friend" do
      before do
        create_ability_accessed_by :fof_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Allows Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end

    describe "accessed by same public sender" do
      before do
        u = @tie.sender.subject
        @ability = Ability.new(u)
      end

      it_should_behave_like "Allows Creating"
      it_should_behave_like "Allows Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end

    describe "accessed by different public" do
      before do
        create_ability_accessed_by :public_tie
      end

      it_should_behave_like "Denies Creating"
      it_should_behave_like "Denies Reading"
      it_should_behave_like "Denies Updating"
      it_should_behave_like "Denies Destroying"
    end
  end
end
