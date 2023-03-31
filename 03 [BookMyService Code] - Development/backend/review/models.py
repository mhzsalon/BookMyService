from django.db import models
from userModel.models import CustomUser, ServiceProvider

# Create your models here.
class feedback(models.Model):
    user_id = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    provider_id = models.ForeignKey(ServiceProvider, on_delete=models.CASCADE)
    comment = models.TextField(null=False)
    created = models.DateTimeField(auto_now_add=True, null=True)

    # class Meta:
    #     ordering = ['-created']
    
    def __str__(self):
        return self.comment