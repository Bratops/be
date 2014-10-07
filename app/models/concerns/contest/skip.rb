module Concerns::Contest::Skip
  extend ActiveSupport::Concern

  def compute_skips
    self.answers.sum :skip
  end

  def compute_timing
    self.answers.sum :timespan
  end
end
