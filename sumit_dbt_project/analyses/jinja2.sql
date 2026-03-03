{% set apples = ["Gala", "Pink Lady", "Fuji", "Royal Red"] %}

{% for i in apples %}
    {% if i != "Gala" %}
        {{ i }}
    {% else %}
        I hate {{ i }}
    {% endif %}    
{% endfor %}    