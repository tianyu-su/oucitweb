from django.test import TestCase

# Create your tests here.
def get_img_url(str):
    index = str.find(r'<img')
    if index == -1:
        return ''
    else:
        img_html = str[index:str.find(r'>',index) + 2]
        pattern = r'src=\"[^\"]+\"'
        import re
        res = re.search(pattern, img_html, re.M)
        begin, end = res.span()
        return img_html[begin + 5:end - 1]

if __name__ == '__main__':
   str = r'<a class="cover" target="_blank" href="/p/7795783979da?utm_campaign=maleskine&amp;utm_content=note&amp;utm_medium=seo_notes&amp;utm_source=recommendation"><img src="//upload-images.jianshu.io/upload_images/2436524-1c5febaf712c8dcb.png?imageMogr2/auto-orient/strip|imageView2/1/w/300/h/240" alt="240"></a>'
   print( get_img_url(str))

   # import re
   # print(str.find(r'>', str.find(r'<img')))
   # print(str[str.find(r'<img'):str.find(r'>', str.find(r'<img'))])