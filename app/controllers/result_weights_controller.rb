class ResultWeightsController < ApplicationController
  before_action :set_weights

  def edit
  end

  def update
    @weights.each do |w|
      param = wights_params.find { |p| p[:position] == w.position.to_s }
      w.weight = param[:weight] if param
    end

    if valid?
      ActiveRecord::Base.transaction { @weights.each(&:save) }
      redirect_to edit_result_weights_path, notice: '重み付けを更新しました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private

    def set_weights
      @weights ||= ResultWeight.all_results
    end

    def valid?
      @weights.map(&:valid?).all?
    end

    def wights_params
      params.fetch(:weights, [])
    end
end
