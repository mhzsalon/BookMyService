from django.contrib.auth.base_user import BaseUserManager
from django.utils.translation import gettext as _


class CustomUserManager(BaseUserManager):
    # Creating a user with email as username
    def create_user(self, email, password, name, phone, gender, location, **other_fields):
        if not email:
            raise ValueError(_('Email Not Found'))

        user = self.model(
            email = self.normalize_email(email),
                name = name,
                phone = phone,
                gender= gender,
                location = location,
                user_type = 3,
                **other_fields
            )
        
        user.set_password(password)

        # user.name = name
        # user.phone = phone
        # user.gender = gender
        # user.location = location
        # user.user_type = 6

        user.save(using = self._db)        
        return user
    
    # def create_staff(self, email, password=None, user_type=None):
    #     if not email:
    #         raise ValueError(_('Email Not Found'))

    #     staff = self.model(
    #         email=self.normalize_email(email),
    #     )
        
    #     staff.set_password(password)
    #     staff.user_type = user_type
    #     staff.is_staff = True
    #     staff.save(using=self._db)
    #     return staff
    
     

    def create_superuser(self, email, name, password, phone, location, gender):

        user = self.create_user(
            email=self.normalize_email(email),
            name=name,
            phone=phone,
            password=password,
            location=location,
            gender=gender,
        )
        user.is_superuser = True
        user.user_type = 1
        user.is_active= True
        # user.is_staff = True
        user.is_verified = True
        user.save(using=self._db)

        # # return user
        # extra_fields.setdefault('user_type', 1)
        # # extra_fields.setdefault('is_superuser', True)
        # extra_fields.setdefault('is_active', True)

        # if extra_fields.get('user_type') != 1:
        #     raise ValueError(_('Superuser must have is_staff = True.'))
        
        # # if extra_fields.get('is_superuser') is not True:
        # #     raise ValueError(_('Superuser must have is_superuser = True.'))

        return user

    def get_full_name(self):
        full_name = '%s %s' % (self.first_name, self.last_name)
        return full_name.strip()

    def get_short_name(self):
        return self.first_name