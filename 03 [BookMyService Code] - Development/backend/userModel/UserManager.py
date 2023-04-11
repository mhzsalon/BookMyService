from django.contrib.auth.base_user import BaseUserManager
from django.utils.translation import gettext as _


class CustomUserManager(BaseUserManager):
    # Creating a user with email as username
    def create_user(self, email, password, name, phone, gender, location, user_type,**other_fields):
        if not email:
            raise ValueError(_('Email Not Found'))

        user = self.model(
            email = self.normalize_email(email),
                name = name,
                phone = phone,
                gender= gender,
                location = location,
                user_type = user_type,
                **other_fields
            )
        
        user.set_password(password)
        user.is_active= True
        user.save(using = self._db)        
        return user
    
    def create_superuser(self, email, name, password, phone, location, gender):

        user = self.create_user(
            email=self.normalize_email(email),
            name=name,
            phone=phone,
            password=password,
            location=location,
            gender=gender,
            user_type = 'Admin'
        )
        user.is_superuser = True
        user.is_active= True
        user.is_staff = True
        user.is_verified = True
        user.save(using=self._db)
        return user

    def get_full_name(self):
        full_name = '%s %s' % (self.first_name, self.last_name)
        return full_name.strip()

    def get_short_name(self):
        return self.first_name