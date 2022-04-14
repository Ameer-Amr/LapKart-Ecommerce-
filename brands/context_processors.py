from .models import Brand


def brand_links(request):
    link = Brand.objects.all()
    return dict(link=link)
