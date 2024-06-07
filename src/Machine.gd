class_name Machine
extends Selectable
var projectile
#endregion
#region Methods
func create_projectile():
	projectile = Projectile.new(self)

func shoot():
	if projectile:
		animation.play("Throw")
		projectile.shoot()
		projectile = null
#endregion
