from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm, UserChangeForm
from . import models
import datetime

class EditProfileForm(forms.ModelForm):
    employment = forms.CharField(max_length=30,label="Employment",required=False)
    location = forms.CharField(max_length=50,label="Location",required=False)
    birthday = forms.DateTimeField(label="Birthday[YYYY-MM-DD]")
    interests = forms.CharField(max_length=30,label="Interest",required=False)
    class Meta:
        model = User
        fields = ["employment", "location", "birthday", "interests"]
