# encoding : utf-8
require 'spec_helper'

describe RetrospectivesController do
  describe "POST #create" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      controller.session[:user] = user
      controller.session[:user_id] = user.id
    end

    after { User.delete_all }

    subject { post :create, retrospective: retrospective  }

    describe "with invalid attributes" do
      let(:retrospective) { FactoryGirl.build(:invalid_retrospective) }

      it 'does not save the new retrospective' do
        expect { subject }.to_not change(Retrospective, :count)
      end

      it 're-renders the index' do
        subject.should redirect_to '/retrospectives'
      end
    end

    describe "with valid attributes" do
      let(:retrospective) { FactoryGirl.attributes_for(:retrospective) }

      it 'saves the new retrospective' do
        expect { subject }.to change(Retrospective, :count).by(1)
      end

      it 're-renders the index' do
        subject.should redirect_to '/retrospectives'
      end
    end
  end

  describe 'GET #send_email' do
    let(:user) { FactoryGirl.create(:user) }

    before { controller.session[:user_id] = user.id }

    after { User.delete_all }

    subject { get "send_email", :id => retrospective.id  }
    let(:team) { FactoryGirl.create(:team, :user_id => user.id ) }
    let(:retrospective) { FactoryGirl.create(:retrospective, :team => team ) }

    context "when fails to send an email" do
      before do
        RetrospectiveMailer.stub(:retrospective_resume).stub(:deliver).and_raise("Exception")
        subject
      end

      it "should return flash message" do
        flash[:error].should eql('Um erro ocorreu! Abra um chamado aê, leke!')
      end
    end

    context 'when successfull send email' do
      before do
        RetrospectiveMailer.stub_chain(:retrospective_resume, :deliver).and_return(nil)
        subject
      end

      it "should return flash message" do
        flash[:notice].should eql("Mensagem enviada com sucesso")
      end
    end
  end
end
