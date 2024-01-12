class WebhooksController < ApplicationController
  before_action :set_webhook, only: %i[ show destroy ]
  skip_before_action :verify_authenticity_token, only: %i[create]

  # GET /webhooks or /webhooks.json
  def index
    @webhooks = Webhook.all
  end

  # GET /webhooks/1 or /webhooks/1.json
  def show
  end

  # POST /webhooks or /webhooks.json
  def create
    @webhook = Webhook.new(webhook_params)
    @webhook.source = params[:source]
    @webhook.data = params

    if @webhook.save
      WebhookJob.perform_later(@webhook)
      render json: {status: :ok}
    else
      render json: {errors: @webhook.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /webhooks/1 or /webhooks/1.json
  def destroy
    @webhook.destroy!

    respond_to do |format|
      format.html { redirect_to webhooks_url, notice: "Webhook was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webhook
      @webhook = Webhook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def webhook_params
      params.permit(:source, :message, :event)
    end
end
