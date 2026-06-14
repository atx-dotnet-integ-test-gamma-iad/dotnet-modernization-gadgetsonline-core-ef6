# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution appears to have transformed successfully — no build errors were detected in any of the projects. The following steps outline how to validate, test, and deploy the migrated application.

---

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or packages that could not be resolved. If any packages are missing or incompatible, check their NuGet.org pages for .NET-compatible versions and update the `.csproj` file accordingly.

---

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

---

## 3. Review Runtime Dependencies

Since this is a web project (`GadgetsOnline`), verify the following:

- **Database connections**: Confirm that connection strings in `appsettings.json` (or equivalent) are correct and that the target database is accessible.
- **Entity Framework migrations**: If the project uses Entity Framework, run the following to verify the database schema is up to date:

```bash
dotnet ef database update
```

- **Static files and wwwroot**: Ensure that all static assets (CSS, JS, images) are present under the `wwwroot` folder.
- **Configuration files**: Confirm that `appsettings.json` and any environment-specific variants (`appsettings.Development.json`, etc.) contain all required keys that were previously in `Web.config`.

---

## 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output (typically `https://localhost:5001` or `http://localhost:5000`) and manually verify that:

- The home page loads correctly.
- Navigation between pages works as expected.
- Any product listing, cart, or checkout functionality behaves correctly.
- Authentication and authorization flows work if applicable.

---

## 5. Execute Automated Tests

If the solution contains test projects, run them with:

```bash
dotnet test
```

Review the test results for any failures. Failures may indicate runtime behavioral differences introduced by the migration that were not caught at compile time.

---

## 6. Check for Windows-Specific API Usage

Even with a successful build, certain APIs may only fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer or review the code manually for usage of:

- `System.Web` remnants
- Windows Registry access
- Windows-specific file path assumptions (e.g., backslashes)
- `HttpContext` usage patterns that differ between ASP.NET and ASP.NET Core

Run the following to surface platform compatibility warnings:

```bash
dotnet build /p:EnableNETAnalyzers=true
```

---

## 7. Validate Middleware and HTTP Pipeline

In ASP.NET Core, the HTTP pipeline is configured in `Program.cs` (and optionally `Startup.cs`). Confirm the following middleware is present and ordered correctly:

- `UseHttpsRedirection`
- `UseStaticFiles`
- `UseRouting`
- `UseAuthentication` / `UseAuthorization` (if applicable)
- `MapControllers` or `MapRazorPages` / `MapDefaultControllerRoute`

---

## 8. Publish the Application

Once local validation is complete, publish the application to a self-contained or framework-dependent deployment:

**Framework-dependent:**
```bash
dotnet publish --configuration Release --output ./publish
```

**Self-contained (example for Linux x64):**
```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained true --output ./publish
```

Verify the contents of the `./publish` folder before deploying to the target environment.