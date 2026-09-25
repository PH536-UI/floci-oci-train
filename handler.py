import json, time
from fdk import response

def handler(ctx, data=None):
    try:
        raw = data.getvalue().decode() if data else "{}"
        body = json.loads(raw) if raw else {}
        path = body.get("path", "/api/v1/resource")
    except:
        path = "/api/v1/resource"
    print(f"[FLOCI-OCI] HIT path={path}", flush=True)
    if "health" in path:
        payload = {"status":"ok","provider":"OCI","ts":int(time.time()),"msg":"Tanque de guerra ON"}
        return response.Response(ctx, response_data=json.dumps(payload), headers={"Content-Type":"application/json"}, status_code=200)
    item = {"pk":"demo","sk":str(int(time.time())),"hit":True}
    payload = {"status":"ok","stored":item,"msg":"Why pay for S3 when floci is free? - Now on OCI!"}
    return response.Response(ctx, response_data=json.dumps(payload), headers={"Content-Type":"application/json"}, status_code=200)
