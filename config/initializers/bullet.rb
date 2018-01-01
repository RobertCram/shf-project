if defined? Bullet
  Bullet.enable = true
  Bullet.alert = true
  Bullet.bullet_logger = true

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'Company',
                association: :shf_applications

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'Company',
                association: :business_categories

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'Company',
                association: :addresses

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'ShfApplication',
                association: :business_categories

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'ShfApplication',
                association: :shfapplications_business_categories

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'Address',
                association: :region

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'Address',
                association: :kommun

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'BusinessCategory',
                association: :shf_applications

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'BusinessCategory',
                association: :businesscategories_shf_applications

  Bullet.add_whitelist type: :unused_eager_loading,
                 class_name: 'User',
                association: :shf_applications
end
