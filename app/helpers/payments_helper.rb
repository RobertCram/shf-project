module PaymentsHelper

  def expire_date_label_and_value(entity)
    if entity.is_a? User
      expire_date = entity.membership_expire_date
      tooltip_title = "#{t('users.show.membership_expire_date_tooltip')}"
    else
      expire_date = entity.branding_expire_date # Company
      tooltip_title = "#{t('companies.show.branding_fee_expire_date_tooltip')}"
    end

    if !expire_date
      return field_or_none("#{t('activerecord.attributes.payment.expire_date')}",
                           "#{t('none')}", label_class: 'standard-label')
    end

    tag.p do
      concat tag.span "#{t('activerecord.attributes.payment.expire_date')}: ",
                      class: 'standard-label'
      concat tag.span "#{expire_date}", class: expire_date_css_class(expire_date)
      concat ' '
      concat tag.span class: 'glyphicon glyphicon-info-sign',
                      title: tooltip_title,
                      data: {toggle: 'tooltip'}
    end
  end

  def expire_date_css_class(expire_date)
    today = Time.zone.today
    if today < expire_date.months_ago(1)  # expire_date minus one month
      value_class = 'Yes'  # green
    elsif today >= expire_date
      value_class = 'No'
    else
      value_class = 'Maybe'
    end
    value_class
  end

  def payment_notes_label_and_value(entity)
    if entity.is_a? User
      notes = entity.membership_payment_notes
    else
      notes = entity.branding_payment_notes
    end

    if !notes || notes.empty?
      return field_or_none("#{t('activerecord.attributes.payment.notes')}",
                           "#{t('none')}", label_class: 'standard-label')
    end
    return field_or_none("#{t('activerecord.attributes.payment.notes')}",
                         notes, label_class: 'standard-label')
  end
end
