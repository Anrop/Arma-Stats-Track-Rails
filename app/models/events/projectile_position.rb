class Events::ProjectilePosition < Event
  embeds_one :projectile, class_name: 'Schemas::Projectile'

  validates_presence_of :projectile
end
