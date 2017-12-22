module AdminOnly

  class MemberAppWaitingReasonsController < ApplicationController

    before_action :set_member_app_waiting_reason, only: [:show, :edit, :update, :destroy]
    before_action :authorize_member_app_waiting_reason, only: [:update, :show, :edit]


    def index

      if authorize AdminOnly::MemberAppWaitingReason
        @member_app_waiting_reasons = MemberAppWaitingReason.all
      end

    end


    def show
    end


    def new
      authorize MemberAppWaitingReason
      @member_app_waiting_reason = MemberAppWaitingReason.new
    end


    def edit
    end


    def create
      authorize MemberAppWaitingReason
      @member_app_waiting_reason = MemberAppWaitingReason.new(member_app_waiting_reason_params)

      respond_to do |format|
        if @member_app_waiting_reason.save
          format.html { redirect_to @member_app_waiting_reason, notice: t('admin_only.member_app_waiting_reasons.create.success'), only_path: true  }
          format.json { render :show, status: :created, location: @member_app_waiting_reason }
        else
          format.html { render :new, notice: t('admin_only.member_app_waiting_reasons.create.error') }
          format.json { render json: @member_app_waiting_reason.errors, status: :unprocessable_entity }
        end
      end
    end


    def update
      # TODO must check to see if this reason is in use by any ShfApplications.  If it is, warn the user (or do whatever action makes sense).
      respond_to do |format|
        if @member_app_waiting_reason.update(member_app_waiting_reason_params)
          format.html { redirect_to @member_app_waiting_reason, notice: t('admin_only.member_app_waiting_reasons.update.success'), only_path: true  }
          format.json { render :show, status: :ok, location: @member_app_waiting_reason }
        else
          format.html { render :edit, notice: t('admin_only.member_app_waiting_reasons.update.error') }
          format.json { render json: @member_app_waiting_reason.errors, status: :unprocessable_entity }
        end
      end
    end


    def destroy
      # TODO must check to see if this reason is in use by any ShfApplications.  If it is, warn the user (or do whatever action makes sense).
      if @member_app_waiting_reason.destroy
        respond_to do |format|
          format.html { redirect_to admin_only_member_app_waiting_reasons_url, notice: t('admin_only.member_app_waiting_reasons.destroy.success'), only_path: true  }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { render admin_only_member_app_waiting_reasons_url, notice: t('admin_only.member_app_waiting_reasons.destroy.error') }
          format.json { render json: @member_app_waiting_reason.errors, status: :unprocessable_entity }
        end
      end
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_app_waiting_reason
      @member_app_waiting_reason = MemberAppWaitingReason.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def member_app_waiting_reason_params
      params.require(:admin_only_member_app_waiting_reason).permit(:name_sv, :description_sv, :name_en, :description_en, :is_custom)
    end


    def authorize_member_app_waiting_reason
      authorize @member_app_waiting_reason
    end
  end

end
