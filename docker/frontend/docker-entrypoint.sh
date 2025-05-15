#!/bin/bash
set -e

flask db init || true
flask db migrate -m "entries table" || true
flask db upgrade || true
exec gunicorn --bind 0.0.0.0:80 crudapp:app
