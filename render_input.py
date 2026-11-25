"""Map the published fields of the source JSON to RenderCV input."""

import json
from pathlib import Path


def read(name):
    return json.loads(Path(f"src/{name}.json").read_text())


def skill_items(groups):
    return (item for group in groups for item in group["items"])


def language_label(language):
    return {
        "label": language["language"],
        "details": language["proficiency"].replace("_", " ").capitalize(),
    }


def build_cv():
    person = read("profile")["personal"]
    skills = read("skills")
    certs = read("certifications")
    return {
        "name": "{first_name} {last_name}".format(**person),
        "headline": person["headline"],
        "photo": "../src/picture.png",
        "email": person["contacts"]["email"],
        "location": "{city} ({province}), {postal_code}, {country}".format(**person["location"]),
        "custom_connections": [
            {"placeholder": f"linkedin.com/in/{person['linkedin']}", "url": person["links"]["linkedin"], "fontawesome_icon": "linkedin"},
            {"placeholder": f"github.com/{person['github']}", "url": f"https://github.com/{person['github']}", "fontawesome_icon": "github"},
            {"placeholder": person["links"]["website"], "url": person["links"]["website"], "fontawesome_icon": "globe"},
        ],
        "sections": {
            "Summary": [person["tagline"]],
            "Experience": [
                {
                    "company": e["company"], "position": e["role"], "location": e["location"],
                    "start_date": e["start_date"], "end_date": "present" if e["current"] else e["end_date"],
                    "highlights": e["highlights"], "skills": ", ".join(e["skills"]),
                }
                for e in read("experencies")["experiences"]
            ],
            "Technical skills": [
                {
                    "label": group["category"],
                    "details": "; ".join(
                        f"{s['name']} ({s['description']})" if s["description"] else s["name"]
                        for s in group["items"]
                    ),
                }
                for group in skills["hard_skills"]
            ],
            "Certifications": [
                {"name": f"[Credly profile]({certs['credly_profile']})"},
                *[{"name": c["name"], "date": c["year"]} for c in certs["certifications"]],
            ],
            "Publications": [
                # RenderCV's URL placeholder uses the URL itself as the link label.
                {**p, "authors": [], "date": int(p["date"][:4]), "pdf_target": p["url"]}
                for p in read("publications")["publications"]
            ],
            "Organisational and interpersonal skills": [
                {"bullet": "**{name}**: {description}".format(**s)}
                for s in skill_items(skills["soft_skills"])
            ],
            "Education": [
                {
                    "institution": e["institution"], "area": e["degree"], "date": e["graduation_year"],
                     **({"summary": f"Thesis: *{e['thesis_title']}*" + (f" - {e['grade']}" if e["grade"] else "")}
                       if e["thesis_title"] else {}),
                }
                for e in read("education")["education"]
            ],
            "Languages": [language_label(lang) for lang in read("languages")["languages"]],
            "Interests": [{"label": i["name"], "details": i["description"]} for i in read("interests")["interests"]],
        },
    }


if __name__ == "__main__":
    print(json.dumps({"cv": build_cv(), "locale": {"language": "english", "present": "Present"}}, indent=2))
