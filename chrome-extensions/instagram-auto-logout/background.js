const ALARM_NAME = "clear-instagram-cookies";
const INTERVAL_MINUTES = 8;
const DOMAINS = ["instagram.com", "www.instagram.com"];

function scheduleAlarm() {
  chrome.alarms.create(ALARM_NAME, { periodInMinutes: INTERVAL_MINUTES });
}

chrome.runtime.onInstalled.addListener(scheduleAlarm);
chrome.runtime.onStartup.addListener(scheduleAlarm);

chrome.alarms.onAlarm.addListener((alarm) => {
  if (alarm.name === ALARM_NAME) clearInstagramCookies();
});

async function clearInstagramCookies() {
  for (const domain of DOMAINS) {
    const cookies = await chrome.cookies.getAll({ domain });
    for (const cookie of cookies) {
      const url = `http${cookie.secure ? "s" : ""}://${cookie.domain.replace(/^\./, "")}${cookie.path}`;
      await chrome.cookies.remove({ url, name: cookie.name });
    }
  }
}
