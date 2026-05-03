# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts that may cause runtime issues even if they do not produce build errors.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). Avoid targeting end-of-life versions such as `net5.0` or `net6.0` unless there is a specific reason.

### 4. Run the Application Locally
Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key pages and features to check for runtime errors that would not surface during a build.

### 5. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies** — these do not exist in cross-platform .NET. If any were referenced indirectly, they may cause runtime failures.
- **Windows-specific APIs** — features such as the Windows Registry, `System.Drawing` (GDI+), or MSMQ may require replacement packages (e.g., `System.Drawing.Common` with platform-specific guards).
- **Entity Framework** — if the project uses EF6, consider whether migration to EF Core is needed, as EF6 has limited cross-platform support.
- **Configuration** — verify that `Web.config` settings have been properly migrated to `appsettings.json` and that the application reads configuration correctly via `IConfiguration`.

### 6. Run Existing Tests
If the solution contains test projects, execute them to validate business logic has not been affected:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences introduced by the framework migration.

### 7. Validate Static Assets and Middleware
If this is an ASP.NET Core web application, confirm the following in `Program.cs` or `Startup.cs`:

- Static files middleware is configured (`app.UseStaticFiles()`).
- Routing is configured correctly (`app.UseRouting()`, `app.MapControllers()` or `app.MapDefaultControllerRoute()`).
- Authentication and authorization middleware, if used, is in the correct order.

### 8. Test on Target Platforms
If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues.

### 9. Publish the Application
Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and verify all expected assets, configuration files, and binaries are present before deploying to the target environment.