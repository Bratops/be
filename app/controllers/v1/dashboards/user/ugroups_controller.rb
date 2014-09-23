class V1::Dashboards::User::UgroupsController < V1::BaseController
  include V1::MessageHelper

  def join
    authorize! :join, Edu::Ugroup
    sc = Edu::School.find_by(moeid)
    sg = sc.ugroups.find_by(gcode)
    sta = "error"
    if sg
      en = sg.enrollments.find_by(suid)
      puts en.inspect
      if en && (current_user.user_info.name == en.name)
        sta = "success"
        en.join_user current_user
      end
    end
    render json: {
      msg: tmsg(sta, current_user.xrole.name),
      data: sta == "success" ? en : nil
    }
  end

  private

  def moeid
    params.require(:grp).permit(:moeid)
  end

  def gcode
    params.require(:grp).permit(:gcode)
  end

  def suid
    params.require(:grp).permit(:suid)
  end
end
