from flask import Blueprint

from backend.api.controller import dashboard_api
from backend.api.controller import (

    home,

    dashboard,

    history,

    statistics,

    clear_history,

    download_excel,

    download_csv,

    history_page,

    statistics_page,

    about_page,

    predict,

    start_live_session,

    stop_live_session,

    live_chunk,

    delete_selected_history,

    delete_all_history

)


api = Blueprint(

    "api",

    __name__

)

api.route("/", methods=["GET"])(home)

api.route("/dashboard", methods=["GET"])(dashboard)

api.route("/history", methods=["GET"])(history)

api.route("/statistics", methods=["GET"])(statistics)

api.route("/history", methods=["DELETE"])(clear_history)

api.route("/export/excel",methods=["GET"])(download_excel)

api.route("/export/csv", methods=["GET"])(download_csv)

api.add_url_rule("/history-page", view_func=history_page)

api.add_url_rule("/statistic", view_func=statistics_page)

api.add_url_rule("/about", view_func=about_page)

api.add_url_rule(
    "/api/dashboard",
    view_func=dashboard_api,
    methods=["GET"]
)

api.route(
    "/api/predict",
    methods=["POST"]
)(predict)

api.route(
    "/api/live/start",
    methods=["POST"]
)(start_live_session)

api.route(
    "/api/live/chunk",
    methods=["POST"]
)(live_chunk)

api.route(
    "/api/live/stop",
    methods=["POST"]
)(stop_live_session)

api.route(
    "/api/history/delete-selected",
    methods=["POST"]
)(delete_selected_history)


api.route(
    "/api/history/delete-all",
    methods=["POST"]
)(delete_all_history)