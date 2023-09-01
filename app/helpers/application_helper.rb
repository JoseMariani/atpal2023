module ApplicationHelper
  def human_boolean(boolean)
    boolean ? 'Yes' : 'No'
  end

  def human_boolean_2(boolean)
    boolean ? 'Absent' : 'Present'
  end
  
  def human_abc(grade)
    if grade == "A"
      return 100
    elsif grade == "B"
      return 89
    else
      return 74
    end
  end
  
  def to_cad(price)
    number_to_currency(price, :unit => "C$ ")
  end

  def multiply(a, b)
    return a * b
  end

  def presence(absence)
    absence ? 'Absent' : 'Present'
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def filtered_agencies
    if current_user.marketer? or current_user.agent?
      current_user.agencies
    else
      Agency.order('name ASC')
    end
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def list_promos(regions)
    promos = []
    prom = []
    regions.map do |region|
      region.promos.map do |promo|
        prom << [promo.description, promo.id, {'data-percentage' => promo.percentage}]
      end
      promos << [region.name, prom]
      prom = []
    end
    promos
  end


end