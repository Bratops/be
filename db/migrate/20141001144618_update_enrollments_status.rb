class UpdateEnrollmentsStatus < ActiveRecord::Migration
  def change
    gi = Edu::Ugroup.where("created_at < ?", Time.new('2014/1/1')).ids
    en = Acn::Enrollment.where(ugroup_id: gi)
    en.update_all(status: "done")
  end
end
