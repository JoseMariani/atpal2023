ActiveAdmin.register_page "Dashboard" do
  controller do
    before_filter :authorize_index, only: :index
    def authorize_index
      authorize :admin, :index?
    end
  end

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Students" do
          ul do
            Student.last(5).map do |student|
              li link_to(student.complete_name, admin_student_path(student))
            end
          end
        end
      end
    end
  end # content
end
